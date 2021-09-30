
class GalleryEvent {

}

class GalleryGetImage extends GalleryEvent {
  int page;
  int size;

  GalleryGetImage({required this.page, required this.size});
}