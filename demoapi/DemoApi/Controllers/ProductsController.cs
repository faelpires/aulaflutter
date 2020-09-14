using System.Collections.Generic;
using System.Threading;
using DemoApi.Models;
using DemoApi.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace DemoApi.Controllers
{
    [Route("[controller]")]
    public class ProductsController : Controller
    {
        private ILogger _logger;
        private IProductsService _service;
        private int _delay = 1500;

        public ProductsController(ILogger<ProductsController> logger, IProductsService service)
        {
            _logger = logger;
            _service = service;

        }

        [HttpGet("/api/products")]
        public ActionResult<List<Product>> GetProducts()
        {
            Thread.Sleep(_delay);
            return _service.GetProducts();
        }

        [HttpGet("/api/products/{id}")]
        public ActionResult<Product> GetProduct(int id)
        {
            Thread.Sleep(_delay);
            return _service.GetProduct(id);
        }

        [HttpPost("/api/products")]
        public ActionResult<Product> AddProduct([FromBody] Product product)
        {
            Thread.Sleep(_delay);
            _service.AddProduct(product);
            return product;
        }

        [HttpPut("/api/products/{id}")]
        public ActionResult<Product> UpdateProduct(int id, [FromBody] Product product)
        {
            Thread.Sleep(_delay);
            _service.UpdateProduct(id, product);
            return product;
        }

        [HttpDelete("/api/products/{id}")]
        public ActionResult<int> DeleteProduct(int id)
        {
            Thread.Sleep(_delay);
            _service.DeleteProduct(id);
            //_logger.LogInformation("products", _products);
            return id;
        }
    }
}