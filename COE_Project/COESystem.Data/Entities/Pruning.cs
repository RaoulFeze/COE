namespace COESystem.Data.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pruning")]
    public partial class Pruning
    {
        [Key]
        public int PruningStatusID { get; set; }

        public int CrewSiteID { get; set; }

        public virtual CrewSite CrewSite { get; set; }
    }
}
