function updateHandLink(isUpvote, isDownVoter, picId, upvotesCount, downvotesCount){
	// contenedor de la imagen
	var pic = $("#pic-show-" + picId);
	var disabledUrl = '#';
	// links
	var likeLink = pic.find(".like-link");
	var dislikeLink = pic.find(".dislike-link");

	var activeClassName = "link-active";

	likeLink.find(".count").text(upvotesCount);
	dislikeLink.find(".count").text(downvotesCount);

	if ( isUpvote ) {
		likeLink.addClass(activeClassName);
		dislikeLink.removeClass(activeClassName);
	}
	else if ( isDownVoter ) {
		likeLink.removeClass(activeClassName);
		dislikeLink.addClass(activeClassName);
	} else { // no voter
		likeLink.removeClass(activeClassName);
		dislikeLink.removeClass(activeClassName);
	}

}
