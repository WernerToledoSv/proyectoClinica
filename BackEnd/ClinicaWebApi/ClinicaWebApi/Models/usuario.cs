using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ClinicaWebApi.Models
{
    [Table("usuario")]
    public class usuario
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("rol")]
        [Required]
        public int IdRol { get; set; }

        [ForeignKey("lugar")]
        public int? IdLugar { get; set; }

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
        [Column(TypeName = "char(1)")] // Assuming 'm' or 'f'
        public char Sexo { get; set; }

        [Required]
        [MaxLength(50)]
        public string Cel { get; set; }

        [Required]
        [EmailAddress]
        [MaxLength(255)]
        public string Email { get; set; }

        [Required]
        public DateTime FechaIngreso { get; set; }

        [Required]
        public string Estado { get; set; } = "disponible";

        // Navigation properties
        public virtual rol Rol { get; set; }
        public virtual lugar Lugar { get; set; }
    }
}
