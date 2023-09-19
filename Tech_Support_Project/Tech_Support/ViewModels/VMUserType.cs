using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace Tech_Support.ViewModels;

public partial class VMUserType
{
    public int TipId { get; set; }

    public string Naziv { get; set; } = null!;
    [XmlIgnore]
    public virtual ICollection<VMUser> Korisniks { get; set; } = new List<VMUser>();
}
