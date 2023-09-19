using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TechSupport.DAL.Migrations
{
    /// <inheritdoc />
    public partial class AddColumnToKorisnikTableZaposlen : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Zaposlen",
                schema: "ePodrska",
                table: "korisnik",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Zaposlen",
                schema: "ePodrska",
                table: "korisnik");
        }
    }
}
