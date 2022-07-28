using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using ShapeAssessment.Models;

namespace ShapeAssessment.Models
{
    public partial class ShapeContext : DbContext
    {
        public ShapeContext()
        {
        }

        public ShapeContext(DbContextOptions<ShapeContext> options)
            : base(options)
        {
        }

        public virtual DbSet<User> Users { get; set; } = null!;
        public virtual DbSet<UserLoginHistory> UserLogins { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=.\\SQLExpress;Database=Shape;Trusted_Connection=True;");//(Helpers.Constants.CONNECTION_STRING);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User");

                entity.HasIndex(e => e.Email, "UniqueEmail")
                    .IsUnique();

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("smalldatetime")
                    .HasDefaultValueSql("(getutcdate())");

                entity.Property(e => e.Email)
                    .HasMaxLength(320)
                    .IsUnicode(false);

                entity.Property(e => e.Firstname).HasMaxLength(24);

                entity.Property(e => e.Lastname).HasMaxLength(24);

                entity.Property(e => e.Password).IsUnicode(false);

                entity.Property(e => e.UpdatedDate)
                    .HasColumnType("smalldatetime")
                    .HasDefaultValueSql("(getutcdate())");
            });

            modelBuilder.Entity<UserLoginHistory>(entity =>
            {
                entity.ToTable("UserLoginHistory");

                entity.Property(e => e.Ip)
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasColumnName("IP");

                entity.Property(e => e.LocalTimeHoursOffset).HasColumnType("decimal(3, 1)");

                entity.Property(e => e.LoginDate)
                    .HasColumnType("smalldatetime")
                    .HasDefaultValueSql("(getutcdate())");

                entity.Property(e => e.LoginToken)
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.LogoutDate).HasColumnType("smalldatetime");

                entity.Property(e => e.TokenExpiryDate).HasColumnType("smalldatetime");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserLogins)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_UserLogin_User");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

        public DbSet<ShapeAssessment.Models.UserRegistration>? UserRegistration { get; set; }
    }
}
