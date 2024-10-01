using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ClinicaWebApi.Models
{
    [Table("cita")]
    public class cita
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("paciente")]
        [Required]
        public int IdPaciente { get; set; }

        [ForeignKey("tipoConsulta")]
        [Required]
        public int IdTipoConsulta { get; set; }

        [ForeignKey("usuario")]
        [Required]
        public int IdUsuario { get; set; }

        [Required]
        public DateTime FechaCita { get; set; }

        [Required]
        public TimeSpan HoraCita { get; set; }

        [Required]
        public string Estado { get; set; } = "citado";

        // Navigation properties
        public virtual paciente Paciente { get; set; }
        public virtual tipoConsulta TipoConsulta { get; set; }
        public virtual usuario Usuario { get; set; }
    }
}
