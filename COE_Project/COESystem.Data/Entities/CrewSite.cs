namespace COESystem.Data.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CrewSite")]
    public partial class CrewSite
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CrewSite()
        {
            SiteHazards = new HashSet<SiteHazard>();
        }

        public int CrewSiteID { get; set; }

        public int SiteID { get; set; }

        [Required]
        [StringLength(100)]
        public string TaskDescription { get; set; }

        public TimeSpan? TimeOnSite { get; set; }

        public TimeSpan? TimeOffSite { get; set; }

        public DateTime? Mulch { get; set; }

        public DateTime? Prune { get; set; }

        [StringLength(100)]
        public string Actionrequired { get; set; }

        [StringLength(100)]
        public string AdditionalComments { get; set; }

        public int CrewID { get; set; }

        public virtual Crew Crew { get; set; }

        public virtual Site Site { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SiteHazard> SiteHazards { get; set; }
    }
}
