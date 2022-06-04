// WRITE A NEW STORY (GOD MODE)
let writenews;
let newsStoryHeader;
let newsstoryBody;
let postStoryButton;
let errormessage;

// NEWSSTORY NEWSSTANDS
let newspaper;
let date;
let news;
let jailtime;

let storiesContainer;
let storyTypeHeader;

// Story from the backend
let payload;

if (typeof window !== 'undefined') {
	window.addEventListener('message', (event) => {
		payload = event.data.story;

		if (event.data.action === 'show') {
			requestAnimationFrame(() => {
				newspaper = document.querySelector('.newspaper');

				date = document.querySelector('.date p');
				news = document.querySelector('.news');
				jailtime = document.querySelector('.jalitime');

				storiesContainer = document.querySelector('.news-histories');
				storyTypeHeader = document.querySelector('.story-type-header');

				date.innerHTML = moment().format('MMMM Do YYYY');

				setupStories(event.data.paper);

				newspaper.classList.remove('hidden');
			});
		}

		if (event.data.action === 'newstory') {
			requestAnimationFrame(() => {
				writenews = document.querySelector('.newstory');

				newsStoryHeader = document.querySelector('#newsstory-header');
				newsstoryBody = document.querySelector('#newsstory-body');
				postStoryButton = document.querySelector('.publish-button');
				errormessage = document.querySelector('.error-message');

				postStoryButton.addEventListener('click', () => {
					if (newsStoryHeader.value && newsstoryBody.value) {
						$.post(
							'https://newsstands/publishStory',
							JSON.stringify({
								header: newsStoryHeader.value,
								body: newsstoryBody.value,
							})
						);

						newsStoryHeader.value = '';
						newsstoryBody.value = '';

						hideGUI();
					}
				});

				writenews.classList.remove('hidden');
			});
		}
	});

	window.addEventListener('keydown', (event) => {
		if (event.key === 'Escape') {
			hideGUI();
		}
	});
}

function setupStories(storyType) {
	news.classList.remove('hidden');

	if (!storyType) {
		return;
	}

	if (storyType === 'news') {
		storyTypeHeader.innerHTML = 'Latest news';

		payload.forEach((story) => {
			const storyElement = document.createElement('div');

			storyElement.innerHTML = `
			<div class="news-story">
				<h3>${story.header}</h3>
				<p>
					${
						story.jailed_time
							? `<strong>${
									story.jailed_player
							  }</strong> has been sentenced for <strong>${
									story.jailed_time
							  } month${
									story.jailed_time > 1 ? 's' : ''
							  }</strong>!`
							: story.body
					}
				</p>
			</div>

			<hr />
			`;

			storiesContainer.appendChild(storyElement);
		});
	}

	if (storyType === 'jailtime') {
		storyTypeHeader.innerHTML = 'Jail sentences';

		payload.forEach((story) => {
			const storyElement = document.createElement('div');

			storyElement.innerHTML = `
			<div class="news-story">
				<h3>${story.header}</h3>
				<p>
					${
						story.jailed_time
							? `<strong>${
									story.jailed_player
							  }</strong> has been sentenced for <strong>${
									story.jailed_time
							  } month${
									story.jailed_time > 1 ? 's' : ''
							  }</strong>!`
							: story.body
					}
				</p>
			</div>

			<hr />
			`;

			storiesContainer.appendChild(storyElement);
		});
	}

	if (storyType === 'robberies') {
		storyTypeHeader.innerHTML = 'Latest robberies'

		payload.forEach((story) => {
			const storyElement = document.createElement('div');

			storyElement.innerHTML = `
			<div class="news-story">
				<h3>${story.header}</h3>
				<p>
					${story.body}	
				</p>
			</div>

			<hr />
			`;

			storiesContainer.appendChild(storyElement);
		});
	}
		payload.forEach((story) => {
			const storyElement = document.createElement('div');

			storyElement.innerHTML = `
			<div class="news-story">
				<h3>${story.header}</h3>
				<p>
					${
						story.jailed_time
							? `<strong>${
									story.jailed_player
							  }</strong> has been sentenced for <strong>${
									story.jailed_time
							  } month${
									story.jailed_time > 1 ? 's' : ''
							  }</strong>!`
							: story.body
					}
				</p>
			</div>

			<hr />
			`;

			storiesContainer.appendChild(storyElement);
		});
}

/** Hide newspaper */
function hideGUI() {
	// Newspaper
	if (writenews) {
		writenews.classList.add('hidden');
	}

	if (newspaper) {
		newspaper.classList.add('hidden');
		news.classList.add('hidden');
		jailtime.classList.add('hidden');
		storiesContainer.innerHTML = '';
	}

	$.post('https://newsstands/hide', JSON.stringify({}));
}
