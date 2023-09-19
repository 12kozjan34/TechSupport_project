using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TechSupport.DAL.Repositories
{
    public interface IRepository <T> where T : class
    {
        IEnumerable<T> GetAll();
        T GetById(int id);
        void Update(int id, T entity);
        void Add(T entity);
    }
}
