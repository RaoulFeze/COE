namespace COESystem.Data.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Grass")]
    public partial class Grass
    {
        [Key]
        public int GrassStatusID { get; set; }

        public int CrewSiteID { get; set; }

        public int GrassCount { get; set; }

        public virtual CrewSite CrewSite { get; set; }
    }
}
