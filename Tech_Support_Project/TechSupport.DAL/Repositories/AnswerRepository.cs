using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.Repositories
{
    public class AnswerRepository : IAnswerRepository
    {
        private readonly ProjektContext dbContext;
        private readonly IMapper mapper;

        public AnswerRepository(ProjektContext _dbContext, IMapper _mapper)
        {
            dbContext = _dbContext;
            mapper = _mapper;
        }

        public void Add(BLAnswer blAnswer)
        {
            var dbAnswer = mapper.Map<Odgovor>(blAnswer);
            dbAnswer.DatumVrijemeOdgovora = DateTime.Now;
            dbContext.Odgovors.Add(dbAnswer);
            dbContext.SaveChanges();
        }

        public IEnumerable<BLAnswer> GetAll()
        {
            return mapper.Map<IEnumerable<BLAnswer>>(dbContext.Odgovors);
        }

        public BLAnswer GetById(int id)
        {
            throw new NotImplementedException();
        }

        public void Update(int id, BLAnswer entity)
        {
            throw new NotImplementedException();
        }
    }
}
