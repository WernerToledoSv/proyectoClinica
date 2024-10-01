using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ClinicaWebApi.Models
{
    [Table("receta")]
    public class receta
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("historialmedico")]
        [Required]
        public int IdHistorialMedico { get; set; }

        [ForeignKey("medicamento")]
        [Required]
        public int IdMedicamento { get; set; }

        [Required]
        public int Dosis { get; set; }

        [Required]
        [MaxLength(150)]
        public string Frecuencia { get; set; }

        [Required]
        [MaxLength(100)]
        public string Duracion { get; set; }

        public string Estado { get; set; } = "no entregado"; // Default value

        // Navigation properties
        public virtual historialMedico HistorialMedico { get; set; }
        public virtual medicamento Medicamento { get; set; }
    }
}
