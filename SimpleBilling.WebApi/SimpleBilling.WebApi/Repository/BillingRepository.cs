
using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace SimpleBilling.Repository;

public interface IRepository<T>
{
    Task<T> GetByIdAsync(int id);
    Task<IEnumerable<T>> GetAllAsync();
}

public class Repository<T> : IRepository<T> where T : class
{
    private string _connectionString;
    private readonly IConfiguration Configuration;
    public Repository(IConfiguration configuration)
    {
        Configuration = configuration;
        this._connectionString = configuration.GetConnectionString("localDbStr");
    }

    public async Task<T> GetByIdAsync(int id)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"SELECT * FROM {typeof(T).Name} WHERE Id = @Id";
            var parameters = new { Id = id };
            return await connection.QuerySingleOrDefaultAsync<T>(query, parameters);
        }
    }

    public async Task<IEnumerable<T>> GetAllAsync()
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var query = $"SELECT * FROM {typeof(T).Name}";
            return await connection.QueryAsync<T>(query);
        }
    }
}
