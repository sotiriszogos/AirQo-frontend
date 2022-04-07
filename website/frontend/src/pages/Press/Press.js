import React from 'react';
import { useInitScrollTop } from 'utils/customHooks';
import Page from '../Page';
import Article from './Article';

const Press = () => {
  useInitScrollTop();
  return (
    <Page>
        <div className="press-page">
            <div className="p-header">
                <div className="content">
                    <div className="press-top">
                        <h2>In the <span className="underline">Press</span></h2>
                        <span className="sub-title">
                                Stories about AirQo that we think you'll love
                        </span>
                    </div>
                </div>
            </div>
            <div className="p-body">
                <div className="content">
                    <div className="press-cards">
                        <div className="card">
                            <Article />
                        </div>
                        <div className="card">
                            <Article />
                        </div>
                        <div className="card">
                            <Article />
                        </div>
                        <div className="card">
                            <Article />
                        </div>
                    </div>
                    <div className="press-cards-lg">
                        <div className="card-lg">
                            <Article />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Page>
  );
};

export default Press;