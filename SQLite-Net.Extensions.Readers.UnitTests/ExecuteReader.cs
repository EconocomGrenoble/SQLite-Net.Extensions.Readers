using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SQLite;
using System.Linq;

namespace SQLite_Net.Extensions.Readers.UnitTests
{
    [TestClass]
    public class ExecuteReader
    {
        private static SQLiteConnection conn;

        [ClassInitialize()]
        public static void ClassInitialize(TestContext testContext)
        {
            var dbName = "sqldbsample";

            conn = new SQLiteConnection(testContext.DeploymentDirectory + dbName);
            conn.CreateTable<Stock>();
            conn.CreateTable<Valuation>();

            var id1 = conn.Insert(new Stock()
            {
                Symbol = "Symbol 1"
            });
            var id2 = conn.Insert(new Stock()
            {
                Symbol = "Symbol 2"
            });

            conn.Insert(new Valuation()
            {
                Price = 20,
                StockId = id1,
                Time = new DateTime(2000, 01, 01)
            });
            conn.Insert(new Valuation()
            {
                Price = 30,
                StockId = id1,
                Time = new DateTime(2000, 01, 02)
            });
            conn.Insert(new Valuation()
            {
                Price = 12.5M,
                StockId = id2,
                Time = new DateTime(2000, 01, 01)
            });
        }
        
        [TestMethod]
        public void ExecuteReader_ReadStocks()
        {
            // Execute reader :
            var readerResults = conn.ExecuteReader("SELECT * FROM Stock");

            Assert.IsTrue(readerResults.Count() == 2);

            // Showing results :
            int i = 1;
            foreach (var readerItem in readerResults)
            {
                Assert.IsTrue(readerItem["Id"] is int);
                Assert.IsTrue((int)readerItem["Id"] == i);
                Assert.IsTrue(readerItem["Symbol"] is string);
                Assert.IsTrue((string)readerItem["Symbol"] == "Symbol " + i);

                i++;
            }
        }

        [TestMethod]
        public void ExecuteReader_ErrorQuery()
        {
            // Execute reader :
            try
            {
                var sumValuations = conn.ExecuteScalar<decimal>("SELECT SUM(InValidColumn) FROM Valuation");
                Assert.Fail("An error must occured.");
            }
            catch (Exception ex)
            {
                Assert.IsTrue(ex is SQLiteException);
            }
        }
    }
}
