using System.Collections.Generic;
using DemoApi.Models;
using DemoApi.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace DemoApi.Controllers
{
    [Route("[controller]")]
    public class CategoryController : Controller
    {
        private ILogger _logger;
        private ICategoryService _service;

        public CategoryController(ILogger<ProductsController> logger, ICategoryService service)
        {
            _logger = logger;
            _service = service;

        }

        [HttpGet("/api/categories")]
        public ActionResult<List<Category>> GetCategories()
        {
            return _service.GetCategories();
        }
   }
}