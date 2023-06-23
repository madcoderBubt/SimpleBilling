namespace SimpleBilling.WebApi.Model;

public class Inventory
{
    public int Id { get; set; }
    public DateTime Date { get; set; }
    public string BillNo { get; set; }
    public int CustomerId { get; set; }
    public decimal TotalDiscount { get; set; }
    public decimal TotalBillAmount { get; set; }
    public decimal DueAmount { get; set; }
    public decimal PaidAmount { get; set; }
    public List<InventoryProduct> Products { get; set; }
    public Customer Customer { get; set; }
}

public class InventoryProduct
{
    public int Id { get; set; }
    public int InventoryId { get; set; }
    public int ProductId { get; set; }
    public decimal Rate { get; set; }
    public decimal Discount { get; set; }
    public int Qty { get; set; }
    public Product Product { get; set; }
}

public class Product
{
    public int Id { get; set; }
    public string Code { get; set; }
    public string Name { get; set; }
    public decimal Rate { get; set; }
}

public class Customer
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Address { get; set; }
    public string Phone { get; set; }
}

