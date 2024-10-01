using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ClinicaWebApi.Models
{
    [Table("medicamento")]
    public class medicamento
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("tipomedida")]
        [Required]
        public int IdTipoMedida { get; set; }

        [Required]
        [MaxLength(255)]
        public string Nombre { get; set; }

        public string Descripcion { get; set; }

        [Required]
        [MaxLength(255)]
        public string Laboratorio { get; set; }

        [Required]
        public int Cantidad { get; set; }

        [Required]
        public string Estado { get; set; } = "disponible";

        // Navigation properties
        public virtual tipoMedida TipoMedida { get; set; }
    }
}
