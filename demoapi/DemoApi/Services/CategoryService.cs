using System.Collections.Generic;
using DemoApi.Models;
using System.Linq;

namespace DemoApi.Services
{
    public class CategoryService : ICategoryService
    {

        private List<Category> _categoryItems;

        public CategoryService()
        {
            _categoryItems = new List<Category>()
            {
                new Category
                {
                    Id = 1,
                    Name = "Celulares",
                },
                new Category
                {
                    Id = 2,
                    Name = "Video Games",
                }
            };
        }

        public List<Category> GetCategories()
        {
            return _categoryItems.OrderBy(p => p.Id).ToList();
        }
    }
}
