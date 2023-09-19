using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.BLModels;

namespace TechSupport.DAL.Repositories
{
    public interface IEmployerRepository : IRepository<BLEmployer>
    {
        int GetCompanyId(int userId);
        IEnumerable<BLEmployer> GetByCompanyId(int companyId);
        int GetLastId();
        int GetEmployerId(int userId);
    }
}
