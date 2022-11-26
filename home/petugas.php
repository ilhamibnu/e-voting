<?php
$kode = 0;
if (isset($_GET['kode'])) {
	$kode = $_GET['kode'];
}
?>

<style>
	p.normal {
		font-size: 12;
		font-weight: bold;
	}
</style>

<?php
$sql = $koneksi->query("SELECT COUNT(ID_CALON) as tot_calon  from tb_votekandidat where flag_id=1");
while ($data = $sql->fetch_assoc()) {
	$calon = $data['tot_calon'];
}

$sql = $koneksi->query("SELECT COUNT(daftarvote_id) as tot_vote  from tb_daftarvote where flag_id=1 and status_id='1'");
while ($data = $sql->fetch_assoc()) {
	$tot_vote = $data['tot_vote'];
}

$sql = $koneksi->query("SELECT COUNT(id_pemilih) as sudah  from tb_votepemilih where status_id='2' and flag_id=1");
while ($data = $sql->fetch_assoc()) {
	$sudah = $data['sudah'];
}

$sql = $koneksi->query("SELECT COUNT(id_pemilih) as belum  from tb_votepemilih where status_id='1' and flag_id=1");
while ($data = $sql->fetch_assoc()) {
	$belum = $data['belum'];
}
?>

<div class="row">
	<div class="col-lg-3 col-6">
		<!-- small box -->
		<div class="small-box bg-info">
			<div class="inner">
				<h3>
					<?php echo $calon; ?>
				</h3>

				<p>Jumlah Kandidat</p>
			</div>
			<div class="icon">
				<i class="ion ion-stats-bars"></i>
			</div>
			<a href="?page=data-calon" class="small-box-footer">Selengkapnya
				<i class="fas fa-arrow-circle-right"></i>
			</a>
		</div>
	</div>
	<!-- ./col -->

	<div class="col-lg-3 col-6">
		<!-- small box -->
		<div class="small-box bg-yellow">
			<div class="inner">
				<h3><?php echo $tot_vote; ?></h3>

				<p>Jumlah Vote Aktif</p>
			</div>
			<div class="icon">
				<i class="ion ion-person-add"></i>
			</div>
			<a href="?page=data-daftarvote" class="small-box-footer">Selengkapnya <i class="fas fa-arrow-circle-right"></i></a>
		</div>
	</div>
	<!-- ./col -->
	<div class="col-lg-3 col-6">
		<!-- small box -->
		<div class="small-box bg-success">
			<div class="inner">
				<h3>
					<?php echo $sudah; ?>
				</h3>

				<p>Sudah Memilih</p>
			</div>
			<div class="icon">
				<i class="ion ion-person-add"></i>
			</div>
			<a href="?page=data-daftarvote" class="small-box-footer">Selengkapnya
				<i class="fas fa-arrow-circle-right"></i>
			</a>
		</div>
	</div>
	<!-- ./col -->
	<div class="col-lg-3 col-6">
		<!-- small box -->
		<div class="small-box bg-danger">
			<div class="inner">
				<h3>
					<?php echo $belum; ?>
				</h3>

				<p>Belum Memlih</p>
			</div>
			<div class="icon">
				<i class="ion ion-person-add"></i>
			</div>
			<a href="?page=data-daftarvote" class="small-box-footer">Selengkapnya
				<i class="fas fa-arrow-circle-right"></i>
			</a>
		</div>
	</div>
</div>


<?php
//list data daftar vote
$query = "select b.daftarvote_id, a.*, coalesce(c.jumlah,0) jumlah 
from tb_votekandidat b 
left join tb_calon a on a.id_calon=b.id_calon
left join (select id_calon, daftarvote_id, count(id_vote) jumlah 
from tb_vote where daftarvote_id=" . $kode . " group by id_calon, daftarvote_id) c on a.id_calon=c.id_calon
where b.flag_id<>9 and b.daftarvote_id=" . $kode . " order by jumlah desc";
//echo $query;
$sql = $koneksi->query($query);

?>
<script>
	function DaftarVote(value) {
		var url = 'index.php?&kode=' + value;
		window.location = url;
	}
</script>