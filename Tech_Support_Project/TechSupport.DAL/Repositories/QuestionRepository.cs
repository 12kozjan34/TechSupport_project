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
    public class QuestionRepository : IQuestionRepository
    {
        private readonly ProjektContext dbContext;
        private readonly IMapper mapper;

        public QuestionRepository(ProjektContext _dbContext, IMapper _mapper)
        {
            dbContext = _dbContext; 
            mapper = _mapper;
        }

        public void Add(BLQuestion blPitanje)
        {
            var dbQuestion = mapper.Map<Pitanje>(blPitanje);
            dbQuestion.DatumVrijemePitanja = DateTime.Now;
            dbContext.Pitanjes.Add(dbQuestion);
            dbContext.SaveChanges();
        }

        public IEnumerable<BLQuestion> GetAll()
        {
            var blQuestions = mapper.Map<IEnumerable<BLQuestion>>(dbContext.Pitanjes);
            return blQuestions;
        }

        public BLQuestion GetById(int id)
        {
            return dbContext.Pitanjes.Where(p => p.PitanjeId == id).Select(p => mapper.Map<BLQuestion>(p)).FirstOrDefault();
        }

        public IEnumerable<BLQuestion> GetByCompanyId(int id)
        {
            var blQuestions = mapper.Map<IEnumerable<BLQuestion>>(dbContext.Pitanjes.Where(p => p.TvrtkaId == id));
            return blQuestions;
        }

        public void Update(int id, BLQuestion blQuestion)
        {
            var dbQuestion = dbContext.Pitanjes.Where(p => p.PitanjeId == id).FirstOrDefault();
            dbQuestion.Odgovoreno = blQuestion.Odgovoreno;
            dbContext.SaveChanges();
        }
    }
}
