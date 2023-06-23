using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SimpleBilling.Repository;
using SimpleBilling.WebApi.Model;

namespace SimpleBilling.WebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]    
    public class BillingController : ControllerBase
    {

        private readonly ILogger<BillingController> _logger;
        private readonly IRepository<Product> productRepo;
        private readonly IRepository<Customer> customerRepo;
        private readonly IInventoryRepo inventoryRepo;

        public BillingController(
            ILogger<BillingController> logger,
            IRepository<Product> proRepo,
            IRepository<Customer> customerRepo,
            IInventoryRepo inventoryRepo)
        {
            _logger = logger;
            this.productRepo = proRepo;
            this.customerRepo = customerRepo;
            this.inventoryRepo = inventoryRepo;
        }

        [HttpGet]
        [Route("Products")]
        public IEnumerable<Product> GetProducts()
        {
            return productRepo.GetAllAsync().Result;
        }
        [HttpGet]
        [Route("Customers")]
        public IEnumerable<Customer> GetCustomers()
        {
            return customerRepo.GetAllAsync().Result;
        }
        [HttpGet]
        [Route("Inventory/{billNo}")]
        public async Task<Inventory> FindInventory(string billNo)
        {
            Inventory inventory = await inventoryRepo.GetByBillNoAsync(billNo);
            
            if(inventory != null)
            {
                inventory.Products = (await inventoryRepo
                    .GetRelatedInventoryProductsAsync(inventory.Id)).ToList();

                //foreach (var item in inventory.Products)
                //{
                //    item.Product = await productRepo.GetByIdAsync(item.Id);
                //}
            }
            return inventory;
        }

        [HttpPost]
        [Route("Inventory")]
        public async Task<ActionResult<Inventory>> SaveInventory(Inventory model)
        {
            if (model == null) return StatusCode(StatusCodes.Status204NoContent);

            if(model.Id > 0) await inventoryRepo.UpdateAsync(model);
            else await inventoryRepo.AddAsync(model);

            foreach (var item in model.Products)
            {
                item.InventoryId = model.Id;
                if (item.Id > 0) await inventoryRepo.UpdateAsync(item);
                else await inventoryRepo.AddAsync(item);
            }

            return Ok(model);
        }

    }
}
