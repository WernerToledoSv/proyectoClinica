using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Numerics;

namespace ClinicaWebApi.Models
{
    [Table("historialmedico")]
    public class historialMedico
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("cita")]
        [Required]
        public int IdCita { get; set; }

        [ForeignKey("enfermero")]
        [Required]
        public int IdEnfermero { get; set; }

        [ForeignKey("doctor")]
        [Required]
        public int IdDoctor { get; set; }

        public float? Temperatura { get; set; }
        public float? Peso { get; set; }

        [MaxLength(15)]
        public string Presion { get; set; }

        public float? Glucosa { get; set; }

        [MaxLength(15)]
        public string Latidos { get; set; }

        public string Padecimiento { get; set; }

        public string Diagnostico { get; set; }

        // Navigation properties
        public virtual cita Cita { get; set; }
        public virtual enfermero Enfermero { get; set; }
        public virtual doctor Doctor { get; set; }
    }
}
