//Clase podcast

class PodcastChapter {
  //Nombre del capitulo
  String title;
  //Podcast al que pertenece
  String parentPod;
  //Descripción
  String description;
  String duration;
  String date;
  String photoUrl;

  PodcastChapter({
    this.title,
    this.parentPod,
    this.description,
    this.duration,
    this.date,
    this.photoUrl
});
  factory PodcastChapter.fromJSON(Map<String, Object> json) {
    return PodcastChapter(
      //TODO: completar cuando este claro el backend
    );
  }
}