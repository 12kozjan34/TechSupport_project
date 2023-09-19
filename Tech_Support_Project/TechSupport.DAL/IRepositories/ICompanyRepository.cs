using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.BLModels;

namespace TechSupport.DAL.Repositories
{
    public interface ICompanyRepository : IRepository<BLCompany>
    {
        int GetCompanyIdModerator(int korisnikId);
        bool GetRequestStatus(int tvrtkaId);
        void SendRequest(int id, bool request);
        IEnumerable<BLCompany> Requests();
    }
}
