import type { ISentence } from './ISentence';
import type { Story } from './story';

export interface INewspaperData {
	stories: Array<Story>;
	sentences: Array<ISentence>;
	jailSentences: Array<any>;
	reporterLevel: number;
	reporterOnDuty: boolean;
	isReporter: boolean;
	playerName: string;
}
