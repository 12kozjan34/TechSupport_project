using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TechSupport.DAL.Migrations
{
    /// <inheritdoc />
    public partial class AddColumnOdgvorenoToPitanje : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Odgovoreno",
                schema: "ePodrska",
                table: "pitanje",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AlterColumn<DateTime>(
                name: "LastLogIn",
                schema: "ePodrska",
                table: "korisnik",
                type: "datetime2",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime2");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Odgovoreno",
                schema: "ePodrska",
                table: "pitanje");

            migrationBuilder.AlterColumn<DateTime>(
                name: "LastLogIn",
                schema: "ePodrska",
                table: "korisnik",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldNullable: true);
        }
    }
}
