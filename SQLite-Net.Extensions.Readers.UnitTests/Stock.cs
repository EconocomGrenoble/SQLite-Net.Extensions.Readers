using SQLite;

namespace SQLite_Net.Extensions.Readers.UnitTests
{
    public class Stock
    {
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }

        [MaxLength(8)]
        public string Symbol { get; set; }
    }
}
