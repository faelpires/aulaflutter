using System.Collections.Generic;
using DemoApi.Models;
using System.Linq;

namespace DemoApi.Services
{
    public class ProductsService : IProductsService
    {

        private List<Product> _productItems;

        public ProductsService()
        {
            _productItems = new List<Product>()
            {
                new Product
                {
                    Id = 1,
                    Name = "iPhone XR",
                    Brand = "Apple",
                    Url = "https://t2.tudocdn.net/492959?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 2,
                    Name = "Mi 9T",
                    Brand = "Xiaomi",
                    Url = "https://t2.tudocdn.net/397296?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 3,
                    Name = "Galaxy S9",
                    Brand = "Samsung",
                    Url = "https://t2.tudocdn.net/320947?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 4,
                    Name = "iPhone X",
                    Brand = "Apple",
                    Url = "https://t2.tudocdn.net/287931?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 5,
                    Name = "Galaxy S10",
                    Brand = "Samsung",
                    Url = "https://t2.tudocdn.net/379785?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 6,
                    Name = "Redmi 9",
                    Brand = "Xiaomi",
                    Url = "https://t2.tudocdn.net/528006?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 7,
                    Name = "Moto G6 Plus",
                    Brand = "Motorola",
                    Url = "https://t2.tudocdn.net/387681?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 8,
                    Name = "Galaxy A30",
                    Brand = "Samsung",
                    Url = "https://t2.tudocdn.net/380994?w=36&h=72&fit=clip" 
                },
                new Product
                {
                    Id = 9,
                    Name = "MI 9 SE",
                    Brand = "Xiaomi",
                    Url = "https://t2.tudocdn.net/379468?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 10,
                    Name = "Redmi Note 8T",
                    Brand = "Xiaomi",
                    Url = "https://t2.tudocdn.net/502625?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 11,
                    Name = "One Zoom",
                    Brand = "Motorola",
                    Url = "https://t2.tudocdn.net/492053?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 12,
                    Name = "ZenFone 5",
                    Brand = "Asus",
                    Url = "https://t2.tudocdn.net/321978?w=36&h=72&fit=clip"
                },
                new Product
                {
                    Id = 13,
                    Name = "Galaxy A01",
                    Brand = "Samsung",
                    Url = "https://t2.tudocdn.net/511547?w=36&h=72&fit=clip"
                }
            };
        }

        public List<Product> GetProducts()
        {
            return _productItems.OrderByDescending(p => p.Id).ToList();
        }

        public Product GetProduct(int id)
        {
            return _productItems.Find(x => x.Id == id);
        }

        public Product AddProduct(Product productItem)
        {
            productItem.Id = _productItems.Max(x => x.Id) + 1;
            _productItems.Add(productItem);
            return productItem;
        }

        public Product UpdateProduct(int id, Product productItem)
        {
            for (var index = _productItems.Count - 1; index >= 0; index--)
            {
                if (_productItems[index].Id == id)
                {
                    _productItems[index] = productItem;
                }
            }
            return productItem;
        }

        public int DeleteProduct(int id)
        {
            for (var index = _productItems.Count - 1; index >= 0; index--)
            {
                if (_productItems[index].Id == id)
                {
                    _productItems.RemoveAt(index);
                }
            }

            return id;
        }


    }
}
