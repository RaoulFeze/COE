namespace COESystem.Data.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Site")]
    public partial class Site
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Site()
        {
            CrewSites = new HashSet<CrewSite>();
        }

        public int SiteID { get; set; }

        public int Pin { get; set; }

        [Required]
        [StringLength(50)]
        public string Neighbourhood { get; set; }

        [StringLength(35)]
        public string StreetAddress { get; set; }

        public int Area { get; set; }

        [StringLength(1000)]
        public string Notes { get; set; }

        public int Grass { get; set; }

        public int SiteTypeID { get; set; }

        public int YardID { get; set; }

        public int CommunityID { get; set; }

        public int SeasonID { get; set; }

        public virtual Community Community { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CrewSite> CrewSites { get; set; }

        public virtual Season Season { get; set; }

        public virtual SiteType SiteType { get; set; }

        public virtual Yard Yard { get; set; }
    }
}
