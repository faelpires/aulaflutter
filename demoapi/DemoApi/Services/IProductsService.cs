using System;
using System.Collections.Generic;
using DemoApi.Models;

namespace DemoApi.Services
{
    public interface IProductsService
    {
        public List<Product> GetProducts();

        public Product GetProduct(int id);

        public Product AddProduct(Product productItem);

        public Product UpdateProduct(int id, Product productItem);

        public int DeleteProduct(int id);
    }
}
