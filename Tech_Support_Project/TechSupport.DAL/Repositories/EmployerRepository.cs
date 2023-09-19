using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.Repositories
{
    public class EmployerRepository : IEmployerRepository
    {
        private readonly ProjektContext dbContext;
        private readonly IMapper mapper;

        public EmployerRepository(ProjektContext _dbContext, IMapper _mapper)
        {
            dbContext = _dbContext;
            mapper = _mapper;
        }

        public void Add(BLEmployer blEmployer)
        {
            dbContext.Zaposleniks.Add(mapper.Map<Zaposlenik>(blEmployer));
            dbContext.SaveChanges();
        }

        public IEnumerable<BLEmployer> GetAll()
        {
            var blEmployers = mapper.Map<IEnumerable<BLEmployer>>(dbContext.Zaposleniks.Include(x => x.Korisnik));
            return blEmployers;
        }

        public BLEmployer GetById(int id)
        {
            return mapper.Map<BLEmployer>(dbContext.Zaposleniks.Include(x=>x.Korisnik).FirstOrDefault(x => x.ZaposlenikId == id));
        }

        public IEnumerable<BLEmployer> GetByCompanyId(int tvrtkaId)
        {
            return mapper.Map<IEnumerable<BLEmployer>>(dbContext.Zaposleniks.Where(x => x.TvrtkaId == tvrtkaId));
        }

        public int GetLastId()
        {
            return dbContext.Zaposleniks.Max(x => x.ZaposlenikId);
        }

        public int GetCompanyId(int userId)
        {
            return dbContext.Zaposleniks.FirstOrDefault(x => x.KorisnikId == userId).TvrtkaId;
        }

        public int GetEmployerId(int userId)
        {
            return dbContext.Zaposleniks.FirstOrDefault(x => x.KorisnikId == userId).ZaposlenikId;
        }

        public void Update(int id, BLEmployer blEmployer)
        {
            throw new NotImplementedException();
        }
    }
}
