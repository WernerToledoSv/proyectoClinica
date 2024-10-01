using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClinicaWebApi.Models
{
    [Table("inventario")]
    public class inventario
    {
        [Key]
        public int Id { get; set; }

        public int IdMedicamento { get; set; }

        public int IdProveedor { get; set; }

        public int? IdReceta { get; set; } // Nullable if optional

        public string Descripcion { get; set; }

        public string Precio { get; set; }

        [Required]
        public float CantidadUnidad { get; set; }

        [Required]
        public DateTime FechaIngreso { get; set; }

        [Required]
        public DateTime? FechaExpira { get; set; } // Nullable for optional expiration date

        [Required]
        public string Accion { get; set; } // Assuming a string to represent ENUM
    }
}
