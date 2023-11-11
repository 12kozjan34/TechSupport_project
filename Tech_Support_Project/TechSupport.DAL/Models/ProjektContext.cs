using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace TechSupport.DAL.Models;

public partial class ProjektContext : DbContext
{
    public ProjektContext()
    {
    }

    public ProjektContext(DbContextOptions<ProjektContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Korisnik> Korisniks { get; set; }

    public virtual DbSet<Odgovor> Odgovors { get; set; }

    public virtual DbSet<Pitanje> Pitanjes { get; set; }

    public virtual DbSet<TipKorisnika> TipKorisnikas { get; set; }

    public virtual DbSet<Tvrtka> Tvrtkas { get; set; }

    public virtual DbSet<Zaposlenik> Zaposleniks { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Server=tcp:ppkdb.database.windows.net,1433;Initial Catalog=projekt;Persist Security Info=False;User ID=sas;Password=Password!;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.HasKey(e => e.KorisnikId).HasName("PK__korisnik__B84D9F56E7BF3362");

            entity.ToTable("korisnik", "ePodrska");

            entity.HasIndex(e => e.TipId, "fk_korisnik_tip_korisnika_idx");

            entity.Property(e => e.KorisnikId).HasColumnName("korisnik_id");
            entity.Property(e => e.Email)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.Ime)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("ime");
            entity.Property(e => e.KorisnickoIme)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("korisnicko_ime");
            entity.Property(e => e.Lozinka)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("lozinka");
            entity.Property(e => e.Prezime)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("prezime");
            entity.Property(e => e.Slika)
                .IsUnicode(false)
                .HasColumnName("slika");
            entity.Property(e => e.TipId).HasColumnName("tip_id");

            entity.HasOne(d => d.Tip).WithMany(p => p.Korisniks)
                .HasForeignKey(d => d.TipId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_korisnik_tip_korisnika");
        });

        modelBuilder.Entity<Odgovor>(entity =>
        {
            entity.HasKey(e => new { e.OdgovorId, e.ZaposlenikId }).HasName("PK__odgovor__5C236DED66820873");

            entity.ToTable("odgovor", "ePodrska");

            entity.HasIndex(e => e.ZaposlenikId, "fk_odgovor_dodijeljen1_idx");

            entity.HasIndex(e => e.PitanjeId, "fk_odgovor_pitanje1_idx");

            entity.Property(e => e.OdgovorId)
                .ValueGeneratedOnAdd()
                .HasColumnName("odgovor_id");
            entity.Property(e => e.ZaposlenikId).HasColumnName("zaposlenik_id");
            entity.Property(e => e.DatumVrijemeOdgovora)
                .HasPrecision(0)
                .HasColumnName("datum_vrijeme_odgovora");
            entity.Property(e => e.PitanjeId).HasColumnName("pitanje_id");
            entity.Property(e => e.Tekst)
                .IsUnicode(false)
                .HasColumnName("tekst");

            entity.HasOne(d => d.Pitanje).WithMany(p => p.Odgovors)
                .HasForeignKey(d => d.PitanjeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_odgovor_pitanje1");

            entity.HasOne(d => d.Zaposlenik).WithMany(p => p.Odgovors)
                .HasForeignKey(d => d.ZaposlenikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_odgovor_dodijeljen1");
        });

        modelBuilder.Entity<Pitanje>(entity =>
        {
            entity.HasKey(e => e.PitanjeId).HasName("PK__pitanje__21342259F3BEAE1F");

            entity.ToTable("pitanje", "ePodrska");

            entity.HasIndex(e => e.TvrtkaId, "fk_pitanje_kategorija1_idx");

            entity.Property(e => e.PitanjeId).HasColumnName("pitanje_id");
            entity.Property(e => e.DatumVrijemePitanja)
                .HasPrecision(0)
                .HasColumnName("datum_vrijeme_pitanja");
            entity.Property(e => e.Naslov)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("naslov");
            entity.Property(e => e.Slika)
                .IsUnicode(false)
                .HasColumnName("slika");
            entity.Property(e => e.Tekst)
                .IsUnicode(false)
                .HasColumnName("tekst");
            entity.Property(e => e.TvrtkaId).HasColumnName("tvrtka_id");
            entity.Property(e => e.Video)
                .IsUnicode(false)
                .HasColumnName("video");

            entity.HasOne(d => d.Tvrtka).WithMany(p => p.Pitanjes)
                .HasForeignKey(d => d.TvrtkaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Tvrtka1");
        });

        modelBuilder.Entity<TipKorisnika>(entity =>
        {
            entity.HasKey(e => e.TipId).HasName("PK__tip_kori__377877B261B41FCB");

            entity.ToTable("tip_korisnika", "ePodrska");

            entity.Property(e => e.TipId).HasColumnName("tip_id");
            entity.Property(e => e.Naziv)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("naziv");
        });

        modelBuilder.Entity<Tvrtka>(entity =>
        {
            entity.HasKey(e => e.TvrtkaId).HasName("PK__tvrtka__4CCB974726618A19");

            entity.ToTable("tvrtka", "ePodrska");

            entity.HasIndex(e => e.ModeratorId, "fk_kategorija_korisnik1_idx");

            entity.Property(e => e.TvrtkaId).HasColumnName("tvrtka_id");
            entity.Property(e => e.BrojZaposlenika).HasColumnName("broj_zaposlenika");
            entity.Property(e => e.ModeratorId).HasColumnName("moderator_id");
            entity.Property(e => e.Naziv)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("naziv");
            entity.Property(e => e.Opis)
                .IsUnicode(false)
                .HasColumnName("opis");
            entity.Property(e => e.PreostaliOdgovori).HasColumnName("preostaliOdgovori");
            entity.Property(e => e.Zahtjev).HasColumnName("zahtjev");

            entity.HasOne(d => d.Moderator).WithMany(p => p.Tvrtkas)
                .HasForeignKey(d => d.ModeratorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_kategorija_korisnik1");
        });

        modelBuilder.Entity<Zaposlenik>(entity =>
        {
            entity.HasKey(e => e.ZaposlenikId).HasName("PK__zaposlen__2C86153D326473CD");

            entity.ToTable("zaposlenik", "ePodrska");

            entity.HasIndex(e => e.KorisnikId, "fk_tvrtka_has_korisnik_korisnik1_idx");

            entity.HasIndex(e => e.TvrtkaId, "fk_tvrtka_has_korisnik_tvrtka1_idx");

            entity.Property(e => e.ZaposlenikId)
                .ValueGeneratedNever()
                .HasColumnName("zaposlenik_id");
            entity.Property(e => e.KorisnikId).HasColumnName("korisnik_id");
            entity.Property(e => e.TvrtkaId).HasColumnName("tvrtka_id");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Zaposleniks)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_tvrtka_has_korisnik_korisnik1");

            entity.HasOne(d => d.Tvrtka).WithMany(p => p.Zaposleniks)
                .HasForeignKey(d => d.TvrtkaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_tvrtka_has_korisnik_tvrtka1");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
