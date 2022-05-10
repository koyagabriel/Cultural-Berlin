import styles from "../styles/Home.module.css";
import { fetcher } from "../lib/utils";
import useSWR from "swr";
import {isEmpty, map} from 'lodash';
import { Card, Tooltip, Result } from "antd";
import {useState} from "react";
import moment from "moment";
import { ArrowRightOutlined } from '@ant-design/icons';

const { Meta } = Card;

const Activity = ({searchParams, setSearchParams}) => {
  const [activities, setActivities] = useState([])
  const fetchActivities = isEmpty(activities) && isEmpty(searchParams) ? `${process.env.NEXT_PUBLIC_API_HOST}/activities` : null;
  useSWR(fetchActivities, fetcher, {
    onSuccess: (data) => {
      setActivities(data.cultural_activities);
      setSearchParams({});
    }
  });

  const searchPath = `${process.env.NEXT_PUBLIC_API_HOST}/activities/search`;
  const searchActivities = !isEmpty(searchParams) ? [searchPath, { params: searchParams }] : null;
  useSWR(searchActivities, fetcher, {
    onSuccess: (data) => {
      setActivities(data.cultural_activities);
    }
  });

  const getDescription = (start_date, end_date) => {
    start_date = moment(start_date);
    end_date = moment(end_date);

    if (start_date.isSame(end_date))  return start_date.format("MMM D, YYYY");
    return `${start_date.format("MMM D")} - ${end_date.format("MMM D, YYYY")}`;
  }

  const getViewDetailsButton = (detailUrl) =>  (
    <Tooltip title="Click to view details">
      <a href={detailUrl} target="_blank">
        View Details
        <ArrowRightOutlined key="detail" twoToneColor="#eb2f96" style={{marginLeft: "5px"}} />
      </a>
    </Tooltip>
  );

  if (isEmpty(activities)) {
    return (
      <Result
        status="404"
        title="No Activities found!"
        subTitle="please check filter criteria"
      />
    )
  }

  return (

    <div className={styles.grid}>
      {
        map(activities, ({title, id, detail_url, description, image_url, start_date, end_date}) => (
          <Card
            key={id}
            hoverable
            className={styles.card}
            cover={<img src={image_url}/>}
            actions={[getViewDetailsButton(detail_url)]}
          >
            <Meta
              title={title}
              description={getDescription(start_date, end_date)}
            />
          </Card>
        ))
      }
    </div>
  )
};

export default Activity;
