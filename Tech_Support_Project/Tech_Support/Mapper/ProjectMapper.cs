using AutoMapper;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;

namespace Tech_Support.Mapper
{
    public class ProjectMapper : Profile
    {
        public ProjectMapper()
        {
            CreateMap<VMUser,BLUser>().ReverseMap();
            CreateMap<VMAnswer,BLAnswer>().ReverseMap();
            CreateMap<VMQuestion,BLQuestion>().ReverseMap();
            CreateMap<VMUserType,BLUserType>().ReverseMap();
            CreateMap<VMCompany,BLCompany>().ReverseMap();
            CreateMap<VMEmployer,BLEmployer>().ReverseMap();
        }
    }
}
