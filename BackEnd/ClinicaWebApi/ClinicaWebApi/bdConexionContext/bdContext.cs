namespace ClinicaWebApi.bdConexionContext
{
    using ClinicaWebApi.Models;
    using Microsoft.EntityFrameworkCore;

    public class bdContext : DbContext
    {
        public bdContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<lugar> lugares { get; set; }
        public DbSet<rol> roles { get; set; }
        public DbSet<usuario> usuarios { get; set; }
        public DbSet<enfermero> enfermeros { get; set; }
        public DbSet<doctor> doctores { get; set; }
        public DbSet<paciente> pacientes { get; set; }
        public DbSet<tipoConsulta> tiposConsulta { get; set; }
        public DbSet<cita> citas { get; set; }
        public DbSet<historialMedico> historialesMedicos { get; set; }
        public DbSet<tipoMedida> tiposMedida { get; set; }
        public DbSet<medicamento> medicamentos { get; set; }
        public DbSet<receta> recetas { get; set; }
        public DbSet<proveedor> proveedores { get; set; }
        public DbSet<inventario> inventarios { get; set; }
    }
}
