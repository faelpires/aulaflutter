using System.Collections.Generic;
using DemoApi.Models;

namespace DemoApi.Services
{
    public interface ICategoryService
    {
        public List<Category> GetCategories();

    }
}