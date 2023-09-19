using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.Mapper
{
    public class DalMapper : Profile
    {
        public DalMapper()
        {
            CreateMap<Korisnik,BLUser>().ReverseMap();
            CreateMap<Odgovor,BLAnswer>().ReverseMap();
            CreateMap<Pitanje,BLQuestion>().ReverseMap();
            CreateMap<TipKorisnika,BLUserType>().ReverseMap();
            CreateMap<Tvrtka,BLCompany>().ReverseMap();
            CreateMap<Zaposlenik,BLEmployer>().ReverseMap();
        }
    }
}
