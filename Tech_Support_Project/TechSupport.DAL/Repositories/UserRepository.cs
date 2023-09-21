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
    public class UserRepository : IUserRepository, IRepository<BLUser>
    {
        private readonly ProjektContext dbContext;
        private readonly IMapper mapper;

        public UserRepository(ProjektContext _dbContext,IMapper _mapper)
        {
            dbContext = _dbContext;
            mapper = _mapper;
            EmployedCheck();
        }

        private void EmployedCheck()
        {
            var users = dbContext.Korisniks;
            var companies = dbContext.Tvrtkas;
            var employers = dbContext.Zaposleniks;

            employers.ToList().ForEach(z =>
            {
                users.ToList().ForEach(k =>
                {
                    if (z.KorisnikId == k.KorisnikId)
                    {
                        k.Zaposlen = true;
                    }
                });
            });
            
            companies.ToList().ForEach(z =>
            {
                users.ToList().ForEach(k =>
                {
                    if (z.ModeratorId == k.KorisnikId)
                    {
                        k.Zaposlen = true;
                    }
                });
            });
        }

        public void Add(BLUser blUser)
        {
            var dbUser = dbContext.Korisniks.FirstOrDefault(x=>x.KorisnickoIme == blUser.KorisnickoIme);

            if (dbUser == null)
            {
                dbUser = mapper.Map<Korisnik>(blUser);
                dbContext.Korisniks.Add(dbUser);
                dbContext.SaveChanges();
            }
        }

        public void Block(BLUser blUser)
        {
            dbContext.Korisniks.FirstOrDefault(x => x.KorisnikId == blUser.KorisnikId).Blocked = true;
            dbContext.SaveChanges();
        }

        private string CreateHash(string password)
        {
            string salt = BCrypt.Net.BCrypt.GenerateSalt();
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password, salt);
            return hashedPassword;
        }

        public bool VerifyPassword(string password, string hashedPassword)
        {
            return BCrypt.Net.BCrypt.Verify(password, hashedPassword);
        }

        public BLUser CheckCredentials(string username, string password)
        {
            var dbUser = dbContext.Korisniks.FirstOrDefault(x => x.KorisnickoIme == username);
            if (dbUser != null)
            {
                if (VerifyPassword(password, dbUser.Lozinka))
                {
                    return mapper.Map<BLUser>(dbUser);
                }
            }
            return null;
        }

        public IEnumerable<BLUser> GetAll()
        {
            return dbContext.Korisniks.Select(x => mapper.Map<Korisnik, BLUser>(x));
        }

        public IEnumerable<string> GetAllImages()
        {
            var images = dbContext.Korisniks.Select(x => x.Slika);
            return images;
        }

        public IEnumerable<BLUser> GetBlockedAccounts()
        {
            IEnumerable<BLUser> blUser = dbContext.Korisniks.ToList().Where(x => x.Blocked == true).Select(x => mapper.Map<Korisnik, BLUser>(x));
            return blUser;
        }

        public BLUser GetById(int id)
        {
            var dbUser = dbContext.Korisniks.FirstOrDefault(x => x.KorisnikId == id);
            var blUser = mapper.Map<Korisnik, BLUser>(dbUser);
            return blUser;
        }

        public int GetUserId(string username)
        {
            return dbContext.Korisniks.FirstOrDefault(x => x.KorisnickoIme == username).KorisnikId;
        }

        public IEnumerable<int> GetUserIdNotIn(IEnumerable<BLEmployer> employers)
        {
            return dbContext.Korisniks.Where(x => !employers.Any(y => y.KorisnikId == x.KorisnikId)).Select(x => x.KorisnikId);
        }

        public BLUser GetUserByName(string name)
        {
            return mapper.Map<Korisnik, BLUser>(dbContext.Korisniks.FirstOrDefault(x => x.KorisnickoIme == name));
        }

        public int NumberOfBlockedAccounts()
        {
            return dbContext.Korisniks.Where(x => x.Blocked == true).Count();
        }

        public void Unblock(int id)
        {
            var dbUser = dbContext.Korisniks.FirstOrDefault(x => x.KorisnikId == id).Blocked = false;
            if (dbUser != null)
            {
                dbContext.SaveChanges(); 
            }
        }

        public void UnBlockMember(string username)
        {
            var dbUser = dbContext.Korisniks.FirstOrDefault(x => x.KorisnickoIme == username);

            if (dbUser.Blocked == true)
            {
                dbUser.Blocked = false;
                return;
            }

            return;
        }

        public void Update(int id, BLUser blUser)
        {
            var dbUser = dbContext.Korisniks.FirstOrDefault(v=>v.KorisnikId == id);

            /*
            if (dbUser.TipId == 1 || dbUser.Zaposlen == true)
            {
                throw new Exception("You can't change from moderator to user, or user is already employed");
            }*/

            dbUser.Ime = blUser.Ime;
            dbUser.Prezime = blUser.Prezime;
            dbUser.KorisnickoIme = blUser.KorisnickoIme;
            dbUser.Email = blUser.Email;
            dbUser.TipId = blUser.TipId;
            dbUser.Zaposlen = false;
            if (blUser.Slika!=null)
            {
                dbUser.Slika = blUser.Slika; 
            }

            dbContext.SaveChanges();
        }

        public void UpdateTime(BLUser blUser)
        {
            var dbUser = dbContext.Korisniks.FirstOrDefault(x => x.KorisnikId == blUser.KorisnikId);
            dbUser.LastLogIn = blUser.LastLogIn;
            dbContext.SaveChanges();
        }
    }
}
