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
            Grasses = new HashSet<Grass>();
            Mulchings = new HashSet<Mulching>();
            Plantings = new HashSet<Planting>();
            Prunings = new HashSet<Pruning>();
            SBMs = new HashSet<SBM>();
            SiteHazards = new HashSet<SiteHazard>();
            Uprootings = new HashSet<Uprooting>();
            Waterings = new HashSet<Watering>();
        }

        public int CrewSiteID { get; set; }

        public int? SiteID { get; set; }

        [StringLength(100)]
        public string TaskDescription { get; set; }

        public TimeSpan? TimeOnSite { get; set; }

        public TimeSpan? TimeOffSite { get; set; }

        [StringLength(100)]
        public string ActionRequired { get; set; }

        public int CrewID { get; set; }

        public virtual Crew Crew { get; set; }

        public virtual Site Site { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Grass> Grasses { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Mulching> Mulchings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Planting> Plantings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Pruning> Prunings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SBM> SBMs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SiteHazard> SiteHazards { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Uprooting> Uprootings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Watering> Waterings { get; set; }
    }
}
