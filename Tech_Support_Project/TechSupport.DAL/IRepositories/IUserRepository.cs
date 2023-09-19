using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.BLModels;

namespace TechSupport.DAL.Repositories
{
    public interface IUserRepository : IRepository<BLUser>
    {
        BLUser CheckCredentials(string username, string password);
        int NumberOfBlockedAccounts();
        IEnumerable<BLUser> GetBlockedAccounts();
        void Unblock(int id);
        void Block(BLUser blKorisnik);
        BLUser GetUserByName(string name);
        int GetUserId(string username);
        IEnumerable<string> GetAllImages();
        void UpdateTime(BLUser user);
        IEnumerable<int> GetUserIdNotIn(IEnumerable<BLEmployer> employers);
    }
}
