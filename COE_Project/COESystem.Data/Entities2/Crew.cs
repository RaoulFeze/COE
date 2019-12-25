namespace COESystem.Data.Entities2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Crew")]
    public partial class Crew
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Crew()
        {
            CrewMembers = new HashSet<CrewMember>();
            CrewSites = new HashSet<CrewSite>();
            ToolsChecklists = new HashSet<ToolsChecklist>();
        }

        public int CrewID { get; set; }

        public DateTime TodayDate { get; set; }

        public int UnitID { get; set; }

        public int? KM_Start { get; set; }

        public int? KM_End { get; set; }

        [StringLength(100)]
        public string AdditionalComments { get; set; }

        public virtual Unit Unit { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CrewMember> CrewMembers { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CrewSite> CrewSites { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ToolsChecklist> ToolsChecklists { get; set; }
    }
}
