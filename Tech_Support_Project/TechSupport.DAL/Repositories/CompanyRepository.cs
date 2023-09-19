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
    public class CompanyRepository : ICompanyRepository
    {
        private readonly ProjektContext dbContext;
        private readonly IEmployerRepository employerRepo;
        private readonly IMapper mapper;

        public CompanyRepository(ProjektContext _dbContext, IMapper _mapper, IEmployerRepository employerRepo)
        {
            dbContext = _dbContext;
            mapper = _mapper;
            this.employerRepo = employerRepo;
            UpdateDataBase();
        }

        private void UpdateDataBase()
        {
            var dbEmployers = employerRepo.GetAll();
            var dbCompanies = dbContext.Tvrtkas.ToList();
            int count = 0;

            foreach (var tvrtka in dbCompanies)
            {
                foreach (var item in dbEmployers)
                {
                    if (item.TvrtkaId == tvrtka.TvrtkaId)
                    {
                        count++;
                    }
                }
                tvrtka.BrojZaposlenika = count;
                count = 0;
                dbContext.SaveChanges();
            }
        }

        public void Add(BLCompany blCompany)
        {
            var dbCompany = dbContext.Tvrtkas.FirstOrDefault(t=>t.Naziv == blCompany.Naziv);

            if (dbCompany == null)
            {
                var company = mapper.Map<Tvrtka>(blCompany);
                dbContext.Tvrtkas.Add(company);
                dbContext.SaveChanges();
            }
        }

        public IEnumerable<BLCompany> GetAll()
        {
            var dbCompanies = dbContext.Tvrtkas.Include(x => x.Moderator).Include(x => x.Zaposleniks);
            var blCompanies = mapper.Map<IEnumerable<BLCompany>>(dbCompanies);
            return blCompanies;
        }

        public BLCompany GetById(int id)
        {
            var dbCompany = dbContext.Tvrtkas.FirstOrDefault(x => x.TvrtkaId == id);
            var blCompany = mapper.Map<BLCompany>(dbCompany);
            return blCompany;
        }

        public bool GetRequestStatus(int companyId)
        {
            return dbContext.Tvrtkas.FirstOrDefault(x => x.TvrtkaId == companyId).Zahtjev == 1 ? true : false;
        }

        public int GetCompanyIdModerator(int userId)
        {
            return dbContext.Tvrtkas.FirstOrDefault(x => x.ModeratorId == userId).TvrtkaId;
        }

        public void SendRequest(int id, bool request)
        {
            var dbCompany = dbContext.Tvrtkas.FirstOrDefault(x => x.TvrtkaId == id);
            dbCompany.Zahtjev = (short)(request == true ? 1 : 0);
            if (dbCompany.Zahtjev == 0)
            {
                dbCompany.PreostaliOdgovori += 10; 
            }
            dbContext.SaveChanges();
        }

        public void Update(int id, BLCompany blCompany)
        {
            var dbCompany = dbContext.Tvrtkas.FirstOrDefault(x => x.TvrtkaId == id);

            if (dbCompany == null)
            {
                return;
            }

            dbCompany.Naziv = blCompany.Naziv;
            dbCompany.Opis = blCompany.Opis;

            dbContext.SaveChanges();
        }

        public IEnumerable<BLCompany> Requests()
        {
            return mapper.Map<IEnumerable<BLCompany>>(dbContext.Tvrtkas.Where(x => x.Zahtjev == 1).Include(x=>x.Moderator));
        }
    }
}
