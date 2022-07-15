import type { IReporterLevels } from './IReporterLevels';

export interface IConfiguration {
	showPrisonSentences: boolean;
	showCityNews: boolean;
	minPublishLevel: number;
	minEditLevel: number;
	minDeleteLevel: number;
	reporter: Array<IReporterLevels>;
}
