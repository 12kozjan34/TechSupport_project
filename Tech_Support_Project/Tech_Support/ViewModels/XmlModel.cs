using System.Xml.Serialization;

namespace Tech_Support.ViewModels
{
    [XmlRoot("XmlModel")]
    public class XmlModel
    {
        [XmlElement("Korisnik")]
        public List<VMUser> Korisnici { get; set; }
    }
}
