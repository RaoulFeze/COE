namespace COESystem.Data.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Mulching")]
    public partial class Mulching
    {
        [Key]
        public int MulchingStatusID { get; set; }

        public int CrewSiteID { get; set; }

        public virtual CrewSite CrewSite { get; set; }
    }
}
