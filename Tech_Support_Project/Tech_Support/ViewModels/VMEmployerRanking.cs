namespace Tech_Support.ViewModels
{
    public class VMEmployerRanking
    {
        public int Id { get; set; }
        public VMUser Eployer { get; set; }
        public int NumberOfQuestions { get; set; }
        public int? TvrtkaId { get; set; }
    }
}
