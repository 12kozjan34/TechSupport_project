using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.BLModels;

namespace TechSupport.DAL.Repositories
{
    public interface IQuestionRepository : IRepository<BLQuestion>
    {
        IEnumerable<BLQuestion> GetByCompanyId(int id);
    }
}
