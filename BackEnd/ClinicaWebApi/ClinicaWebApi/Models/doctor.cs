using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ClinicaWebApi.Models
{
    [Table("doctor")]
    public class doctor
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("rol")]
        [Required]
        public int IdRol { get; set; }

        [Required]
        [MaxLength(100)]
        public string Username { get; set; }

        [Required]
        public string Password { get; set; }

        [Required]
        [MaxLength(255)]
        public string Nombres { get; set; }

        [Required]
        [MaxLength(255)]
        public string Apellidos { get; set; }

        [Required]
        [Column(TypeName = "char(1)")]
        public char Sexo { get; set; }

        [Required]
        [MaxLength(50)]
        public string Cel { get; set; }

        [Required]
        [EmailAddress]
        [MaxLength(255)]
        public string Email { get; set; }

        public string Profesion { get; set; }

        public string NumeroJunta { get; set; }

        [Required]
        public DateTime FechaIngreso { get; set; }

        [Required]
        public string Estado { get; set; } = "disponible";

        // Navigation properties
        public virtual rol Rol { get; set; }
    }
}
