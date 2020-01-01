namespace COESystem.DAL
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using COESystem.Data.Entities;

    public partial class COESystemContext : DbContext
    {
        public COESystemContext()
            : base("name=COEdb")
        {
        }

        public virtual DbSet<Community> Communities { get; set; }
        public virtual DbSet<CorrectiveAction> CorrectiveActions { get; set; }
        public virtual DbSet<Crew> Crews { get; set; }
        public virtual DbSet<CrewMember> CrewMembers { get; set; }
        public virtual DbSet<CrewSite> CrewSites { get; set; }
        public virtual DbSet<District> Districts { get; set; }
        public virtual DbSet<Employee> Employees { get; set; }
        public virtual DbSet<Grass> Grasses { get; set; }
        public virtual DbSet<Hazard> Hazards { get; set; }
        public virtual DbSet<HazardCategory> HazardCategories { get; set; }
        public virtual DbSet<Mulching> Mulchings { get; set; }
        public virtual DbSet<Pruning> Prunings { get; set; }
        public virtual DbSet<SBM> SBMs { get; set; }
        public virtual DbSet<Season> Seasons { get; set; }
        public virtual DbSet<Site> Sites { get; set; }
        public virtual DbSet<SiteHazard> SiteHazards { get; set; }
        public virtual DbSet<SiteType> SiteTypes { get; set; }
        public virtual DbSet<Tool> Tools { get; set; }
        public virtual DbSet<ToolsChecklist> ToolsChecklists { get; set; }
        public virtual DbSet<Unit> Units { get; set; }
        public virtual DbSet<Yard> Yards { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Community>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<Community>()
                .HasMany(e => e.Sites)
                .WithRequired(e => e.Community)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CorrectiveAction>()
                .Property(e => e.CorrectiveActionDescription)
                .IsUnicode(false);

            modelBuilder.Entity<Crew>()
                .Property(e => e.AdditionalComments)
                .IsUnicode(false);

            modelBuilder.Entity<Crew>()
                .HasMany(e => e.CrewMembers)
                .WithRequired(e => e.Crew)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Crew>()
                .HasMany(e => e.CrewSites)
                .WithRequired(e => e.Crew)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Crew>()
                .HasMany(e => e.ToolsChecklists)
                .WithRequired(e => e.Crew)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CrewSite>()
                .Property(e => e.TaskDescription)
                .IsUnicode(false);

            modelBuilder.Entity<CrewSite>()
                .Property(e => e.ActionRequired)
                .IsUnicode(false);

            modelBuilder.Entity<CrewSite>()
                .HasMany(e => e.Grasses)
                .WithRequired(e => e.CrewSite)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CrewSite>()
                .HasMany(e => e.Mulchings)
                .WithRequired(e => e.CrewSite)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CrewSite>()
                .HasMany(e => e.Prunings)
                .WithRequired(e => e.CrewSite)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CrewSite>()
                .HasMany(e => e.SBMs)
                .WithRequired(e => e.CrewSite)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CrewSite>()
                .HasMany(e => e.SiteHazards)
                .WithRequired(e => e.CrewSite)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<District>()
                .Property(e => e.DistrictName)
                .IsUnicode(false);

            modelBuilder.Entity<District>()
                .HasMany(e => e.Yards)
                .WithRequired(e => e.District)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Employee>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<Employee>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<Employee>()
                .Property(e => e.Phone)
                .IsUnicode(false);

            modelBuilder.Entity<Employee>()
                .HasMany(e => e.CrewMembers)
                .WithRequired(e => e.Employee)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Hazard>()
                .Property(e => e.HazardDescription)
                .IsUnicode(false);

            modelBuilder.Entity<Hazard>()
                .HasMany(e => e.CorrectiveActions)
                .WithRequired(e => e.Hazard)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Hazard>()
                .HasMany(e => e.SiteHazards)
                .WithRequired(e => e.Hazard)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<HazardCategory>()
                .Property(e => e.HazardCategoryName)
                .IsUnicode(false);

            modelBuilder.Entity<SBM>()
                .Property(e => e.TaskDescription)
                .IsUnicode(false);

            modelBuilder.Entity<Season>()
                .HasMany(e => e.Sites)
                .WithRequired(e => e.Season)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Site>()
                .Property(e => e.Neighbourhood)
                .IsUnicode(false);

            modelBuilder.Entity<Site>()
                .Property(e => e.StreetAddress)
                .IsUnicode(false);

            modelBuilder.Entity<Site>()
                .Property(e => e.Notes)
                .IsUnicode(false);

            modelBuilder.Entity<Site>()
                .HasMany(e => e.CrewSites)
                .WithRequired(e => e.Site)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SiteType>()
                .Property(e => e.SiteTypeDescription)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<SiteType>()
                .HasMany(e => e.Sites)
                .WithRequired(e => e.SiteType)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Tool>()
                .Property(e => e.ToolDescription)
                .IsUnicode(false);

            modelBuilder.Entity<Tool>()
                .HasMany(e => e.ToolsChecklists)
                .WithRequired(e => e.Tool)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Unit>()
                .Property(e => e.UnitNumber)
                .IsUnicode(false);

            modelBuilder.Entity<Unit>()
                .Property(e => e.UnitDescription)
                .IsUnicode(false);

            modelBuilder.Entity<Unit>()
                .HasMany(e => e.Crews)
                .WithRequired(e => e.Unit)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Yard>()
                .Property(e => e.YardName)
                .IsUnicode(false);

            modelBuilder.Entity<Yard>()
                .HasMany(e => e.Employees)
                .WithRequired(e => e.Yard)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Yard>()
                .HasMany(e => e.Sites)
                .WithRequired(e => e.Yard)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Yard>()
                .HasMany(e => e.Tools)
                .WithRequired(e => e.Yard)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Yard>()
                .HasMany(e => e.Units)
                .WithRequired(e => e.Yard)
                .WillCascadeOnDelete(false);
        }
    }
}
