namespace COESystem.Data.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SBM")]
    public partial class SBM
    {
        [Key]
        public int SBM_StatusID { get; set; }

        public int CrewSIteID { get; set; }

        [Required]
        [StringLength(50)]
        public string TaskDescription { get; set; }

        public virtual CrewSite CrewSite { get; set; }
    }
}
