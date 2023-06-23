using Dapper;
using Microsoft.Data.SqlClient;
using SimpleBilling.WebApi.Model;

namespace SimpleBilling.Repository;

public interface IInventoryRepo
{
    Task<Inventory> GetByBillNoAsync(string billNo);
    Task AddAsync(Inventory entity);
    Task UpdateAsync(Inventory entity);
    Task AddAsync(InventoryProduct entity);
    Task UpdateAsync(InventoryProduct entity);
    Task<IEnumerable<InventoryProduct>> GetRelatedInventoryProductsAsync(int inventoryId);
    //Task<Inventory> GetByBillNoAsync(string billNo);
}
public class InventoryRepo : IInventoryRepo
{
    private string _connectionString;
    public InventoryRepo(IConfiguration configuration)
    {
        this._connectionString = configuration.GetConnectionString("localDbStr");
    }
    public async Task AddAsync(Inventory entity)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"INSERT INTO {typeof(Inventory).Name} "
                + @"([Date]
               ,[BillNo]
               ,[CustomerId]
               ,[TotalDiscount]
               ,[TotalBillAmount]
               ,[DueAmount]
               ,[PaidAmount])" +
                $"VALUES (@Date,@BillNo,@CustomerId,@TotalDiscount,@TotalBillAmount,@DueAmount,@PaidAmount)"; 
            await connection.ExecuteAsync(query, entity);
        }
    }

    public async Task AddAsync(InventoryProduct entity)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"INSERT INTO {typeof(InventoryProduct).Name} " +
                @"([InventoryId]
                ,[ProductId]
                ,[Rate]
                ,[Qty]
                ,[Discount])" +
                "VALUES (@InventoryId, @ProductId, @Rate, @Qty, @Discount)"; 
            await connection.ExecuteAsync(query, entity);
        }
    }

    public async Task<IEnumerable<InventoryProduct>> GetRelatedInventoryProductsAsync(int inventoryId)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"SELECT * FROM {typeof(InventoryProduct).Name} WHERE InventoryId = @inventoryId";
            var parameters = new { inventoryId = inventoryId };
            return await connection.QueryAsync<InventoryProduct>(query, parameters);
        }
    }

    public async Task<Inventory> GetByBillNoAsync(string billNo)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"SELECT * FROM {typeof(Inventory).Name} WHERE BillNo = @billNo";
            var parameters = new { billNo = billNo };
            return await connection.QuerySingleOrDefaultAsync<Inventory>(query, parameters);
        }
    }

    public async Task UpdateAsync(Inventory entity)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"UPDATE {typeof(Inventory).Name} set " +
                @$"[Date] = '{entity.Date.ToString("yyyy-MM-dd HH:mm:ss")}',[BillNo] = @BillNo,[CustomerId] = @CustomerId,[TotalDiscount] = @TotalDiscount,
                [TotalBillAmount] = @TotalBillAmount,[DueAmount] = @DueAmount,[PaidAmount] = @PaidAmount WHERE Id = @Id"; 
            await connection.ExecuteAsync(query, entity);
        }
    }

    public async Task UpdateAsync(InventoryProduct entity)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"UPDATE {typeof(InventoryProduct).Name} " +
                @$"SET [InventoryId] = @InventoryId
                      ,[ProductId] = @ProductId
                      ,[Rate] = @Rate
                      ,[Qty] = @Qty
                      ,[Discount] = @Discount
                 WHERE Id = @Id"; 
            await connection.ExecuteAsync(query, entity);
        }
    }
}
